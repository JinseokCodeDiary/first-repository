readme
# 회고

## 박진석 
  - 여러 모델을 시도를 해보았지만 패키지 문제나 현재 파이썬에서 작동시킬 수 없는 문제들로 확인해볼 수 없었던 것이 아쉬웠고,
    오류 1. cannot import name 'BigGAN' from 'transformers' (/usr/local/lib/python3.10/dist-packages/transformers/__init__.py,
    
    오류 2.Failed to import diffusers.pipelines.stable_diffusion because of the following error (look up to see its traceback):
    cannot import name 'linear_util' from 'jax' (/usr/local/lib/python3.10/dist-packages/jax/__init__.py)
    
  - colab에서 아래의 오류가 발생했을 때 런타임 유형을 gpu로 바꿔서 해결했다.
    오류 - Found no NVIDIA driver on your system. Please check that you have an NVIDIA GPU and installed a driver from http://www.nvidia.com/Download/index.aspx

## 서은재
  - 인체의 자세를 검출해서 다른 가상의 상황에 적용한 이미지를 새로 생성할 수 있는 경험을 할 수 있어서 재밌었다.
  - 이러한 기술을 활용하면, 단순한 이미지 변환을 넘어서 창의적인 표현과 시각적 상상력을 극대화할 수 있는 다양한 가능성을 탐구할 수 있을 것 같다.
  - 예를 들어, 포즈를 바탕으로 캐릭터를 새롭게 디자인하거나, 특정 상황에서의 움직임을 사실적으로 재현하는 등의 작업 말이다.
