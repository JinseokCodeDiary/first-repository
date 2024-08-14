import numpy as np
from tensorflow.keras.layers import Input, LSTM, Embedding, Dense, Concatenate, AdditiveAttention
from tensorflow.keras.models import Model
from tensorflow.keras.callbacks import EarlyStopping

# 하이퍼파라미터
embedding_dim = 128
hidden_size = 256


# 인코더 설계
encoder_inputs = Input(shape=(text_max_len,))
enc_emb = Embedding(src_vocab, embedding_dim)(encoder_inputs)
encoder_lstm1 = LSTM(hidden_size, return_sequences=True, return_state=True, dropout=0.5)
encoder_output1, state_h1, state_c1 = encoder_lstm1(enc_emb)
encoder_lstm2 = LSTM(hidden_size, return_sequences=True, return_state=True, dropout=0.5)
encoder_output2, state_h2, state_c2 = encoder_lstm2(encoder_output1)
encoder_lstm3 = LSTM(hidden_size, return_sequences=True, return_state=True, dropout=0.5)
encoder_output, state_h, state_c = encoder_lstm3(encoder_output2)

# 디코더 설계
decoder_inputs = Input(shape=(None,))
dec_emb_layer = Embedding(tar_vocab, embedding_dim)
dec_emb = dec_emb_layer(decoder_inputs)
decoder_lstm = LSTM(hidden_size, return_sequences=True, return_state=True, dropout=0.5)
decoder_outputs, _, _ = decoder_lstm(dec_emb, initial_state=[state_h, state_c])

# 어텐션 레이어
attn_layer = AdditiveAttention(name='attention_layer')
attn_out = attn_layer([decoder_outputs, encoder_output])

# 어텐션의 결과와 디코더의 hidden state들을 연결
decoder_concat_input = Concatenate(axis=-1, name='concat_layer')([decoder_outputs, attn_out])

# 디코더의 출력층
decoder_softmax_layer = Dense(tar_vocab, activation='softmax', name='decoder_softmax')
decoder_softmax_outputs = decoder_softmax_layer(decoder_concat_input)

# 모델 정의
model = Model(inputs=[encoder_inputs, decoder_inputs], outputs=decoder_softmax_outputs)
model.compile(optimizer='adam', loss='sparse_categorical_crossentropy')
model.summary()

# 모델 학습
es = EarlyStopping(monitor='val_loss', patience=2, verbose=1)
history = model.fit(
    [encoder_input_train, decoder_input_train], 
    decoder_target_train, 
    validation_data=([encoder_input_test, decoder_input_test], decoder_target_test), 
    batch_size=512, 
    callbacks=[es], 
    epochs=50
)

# 인코더 모델 정의
encoder_model = Model(inputs=encoder_inputs, outputs=[encoder_output, state_h, state_c])

# 디코더 모델 정의
decoder_state_input_h = Input(shape=(hidden_size,), name='decoder_state_input_h')
decoder_state_input_c = Input(shape=(hidden_size,), name='decoder_state_input_c')
dec_emb2 = dec_emb_layer(decoder_inputs)
decoder_outputs2, state_h2, state_c2 = decoder_lstm(dec_emb2, initial_state=[decoder_state_input_h, decoder_state_input_c])
attn_out_inf = attn_layer([decoder_outputs2, encoder_output])
decoder_inf_concat = Concatenate(axis=-1, name='concat')([decoder_outputs2, attn_out_inf])
decoder_outputs2 = decoder_softmax_layer(decoder_inf_concat)

# 최종 디코더 모델
decoder_model = Model(
    [decoder_inputs, encoder_output, decoder_state_input_h, decoder_state_input_c],
    [decoder_outputs2, state_h2, state_c2]
)

# 디코딩 함수
def decode_sequence(input_seq):
    e_out, e_h, e_c = encoder_model.predict(input_seq)
    
    target_seq = np.zeros((1, 1))
    target_seq[0, 0] = tar_word_to_index.get('sostoken', 0)  # <SOS> 토큰의 인덱스
    
    stop_condition = False
    decoded_sentence = ''
    
    while not stop_condition:
        output_tokens, h, c = decoder_model.predict([target_seq, e_out, e_h, e_c])
        sampled_token_index = np.argmax(output_tokens[0, -1, :])
        sampled_token = tar_index_to_word.get(sampled_token_index, '')
        
        if sampled_token != 'eostoken':
            decoded_sentence += ' ' + sampled_token
        
        if sampled_token == 'eostoken' or len(decoded_sentence.split()) >= (headlines_max_len - 1):
            stop_condition = True
        
        target_seq = np.zeros((1, 1))
        target_seq[0, 0] = sampled_token_index
        e_h, e_c = h, c

    return decoded_sentence

# 텍스트 변환 함수
def seq2text(input_seq):
    return ' '.join([src_index_to_word.get(i, '') for i in input_seq if i != 0])

# 요약문 변환 함수
def seq2summary(input_seq):
    return ' '.join([tar_index_to_word.get(i, '') for i in input_seq if i != 0])

# 결과 출력
for i in range(50, 100):
    print("원문 :", seq2text(encoder_input_test[i]))
    print("실제 요약 :", seq2summary(decoder_input_test[i]))
    print("예측 요약 :", decode_sequence(encoder_input_test[i].reshape(1, -1)))
    print("\n")
//회고 박진석 : 파일 저장 습관화, 데이터 전처리의 중요성을 알아갈 수 있는 경험이었다.
