# 결과/회고
## 결과

### meaniou
    - 개선된 모델에서 가장 높은 meaniou가 나왔으며 유의미한 개선을 달성했다.
        - encdoer/decoder = 0.474
        - Unet(original) = 0.476
        - Unet(encoder=vgg16) = 0.713
        
### loss(세 모델을 비교하기 위해 epoch수를 동일하게 맞춰줌)
    - loss는 Unet(original)에서 가작 적게 나왔지만 Unet(encoder=vgg16)의 loss 그래프를 보면 계속 떨어지고
      있으므로 과적합이 일어 났을 땐 수치상 의미없는 차이가 나올 것으로 생각됩니다
        - encdoer/decoder = 1이상
        - Unet(original) = 0(loss, val_loss둘 다 0)
        - Unet(encoder=vgg16) = 약 0.4
        
### segmention 이미지
    - ipynb파일 참고 바랍니다.    
## 회고

### 이번 프로젝트는 segmention 실습뿐만아니라 앞으로 발전해 나갈 수 있도록 <br> 나 스스로 과제를 만들어주는 노드였다  

    - encoder 부분에 vgg16모델을 넣어 encoder를 분류 모델의 fully connected layer이전 부분을 사용하는 점이 새롭고 흥미로웠다.
    - vgg16모델보다 개선된 xception이나 EfficientNet을 사용해서 meaniou를 비교해보아야겠다.
    - cv에 관심을 가졌을 땐 이미지 분류모델 때문에 관심을 가지게 되었는데 프로젝트와 아이펠 커리큘럼을 진행할수록
      이미지 생성이나 세그멘테이션등에 더 관심을 가지게 되고 이번 프로젝트 덕분에 그 task에 조금 더 알아갈 수 있어
      유익했다.
    - encoder 부분을 pretrain된 모델을 사용했으니 decoder부분을 어떻게 해서 개선할 수 있는지 고민해야할 것 같고
      이 프로젝트 덕분에 더 발전할 수 있게 하는 숙제를 하나 만들었다.
    - model-subclassing을 백지상태에서 코딩하는 것을 할 수 있도록 파이썬 코딩능력도 발전시켜야 할 것 같다. 
