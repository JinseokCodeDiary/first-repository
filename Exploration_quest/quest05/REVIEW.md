코더: `김재이, 박진석  `  
리뷰어: `김동규, 김기홍, 정권영`

- [x]  **1. 주어진 문제를 해결하는 완성된 코드가 제출되었나요? (완성도)**
    - 문제에서 요구하는 최종 결과물이 첨부되었는지 확인
    - 문제를 해결하는 완성된 코드란 프로젝트 루브릭 3개 중 2개, 
    퀘스트 문제 요구조건 등을 지칭
        - 해당 조건을 만족하는 부분의 코드 및 결과물을 캡쳐하여 사진으로 첨부

- [x]  **2. 프로젝트에서 핵심적인 부분에 대한 설명이 주석(닥스트링) 및 마크다운 형태로 잘 기록되어있나요? (설명)**
    - [x]  모델 선정 이유
    - [x]  하이퍼 파라미터 선정 이유
    - [x]  데이터 전처리 이유 또는 방법 설명
       ```
          def positional_encoding(self, position, d_model):
          # 각도 배열 생성
          angle_rads = self.get_angles(
              position=tf.range(position, dtype=tf.float32)[:, tf.newaxis],
              i=tf.range(d_model, dtype=tf.float32)[tf.newaxis, :],
              d_model=d_model)

          # 배열의 짝수 인덱스에는 sin 함수 적용
          sines = tf.math.sin(angle_rads[:, 0::2])
          # 배열의 홀수 인덱스에는 cosine 함수 적용
          cosines = tf.math.cos(angle_rads[:, 1::2])

          # sin과 cosine이 교차되도록 재배열
          pos_encoding = tf.stack([sines, cosines], axis=0)
          pos_encoding = tf.transpose(pos_encoding,[1, 2, 0]) 
          pos_encoding = tf.reshape(pos_encoding, [position, d_model])

          pos_encoding = pos_encoding[tf.newaxis, ...]
          return tf.cast(pos_encoding, tf.float32)

          def call(self, inputs):
          return inputs + self.pos_encoding[:, :tf.shape(inputs)[1], :]  
       ```
       
  
- [x]  **3. 체크리스트에 해당하는 항목들을 수행하였나요? (문제 해결)**
    - [x]  데이터를 분할하여 프로젝트를 진행했나요? (train, validation, test 데이터로 구분)
    - [x]  하이퍼파라미터를 변경해가며 여러 시도를 했나요?  
      tfDataset 객체를 사용하여 입출력 및 디코드 입력 텐서를 설계하고 파이프라일을 구축했습니다.
      ```
          BATCH_SIZE = 64
          BUFFER_SIZE = 50000

          # 디코더는 이전의 target을 다음의 input으로 사용합니다.
          # 이에 따라 outputs에서는 START_TOKEN을 제거하겠습니다.
          dataset = tf.data.Dataset.from_tensor_slices((
              {
                  'inputs': questions,
                  'dec_inputs': answers[:, :-1]
              },
              {
                  'outputs': answers[:, 1:]
              },
          ))

          dataset = dataset.cache()
          dataset = dataset.shuffle(BUFFER_SIZE)
          dataset = dataset.batch(BATCH_SIZE)
          dataset = dataset.prefetch(tf.data.experimental.AUTOTUNE)
          ```

    - [x]  각 실험을 시각화하여 비교하였나요?
      - Positional Encoding 결과의 시각화
      - 학습률 변화에 따른 추이 시각화



- [x]  **4. 프로젝트에 대한 회고가 상세히 기록 되어 있나요?**
  회고에 덧붙여 각자의 바람, 장차 계획 등의 언급이 짤막하게 언급되어 있습니다.  
      

- [ ]  **5.  앱으로 구현하였나요?**
    - [ ]  구현된 앱이 잘 동작한다.
    - [ ]  모델이 잘 동작한다.