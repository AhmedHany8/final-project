from flask import Flask, jsonify,request
import base64
import cv2
import numpy as np
# import matplotlib.pyplot as plt
# %matplotlib inline
# from IPython.display import Image




app = Flask(__name__)

@app.route('/api',methods = ['POST'])
def processedImagef():
    res = {}
    imgrequest = request.json # json request
    imgbase64 = imgrequest['imgstr'] # image in base 64
    inputImg = base64.b64decode(imgbase64)
    with open("InputImage.png", "wb") as fh:
        fh.write(inputImg)

    img = cv2.imread("InputImage.png",0)


    #preprocessing Code



    
    blur = cv2.GaussianBlur(img,(5,5),0)
    ret3,th3 = cv2.threshold(blur,0,255,cv2.THRESH_BINARY_INV+cv2.THRESH_OTSU)
    thin = cv2.ximgproc.thinning(th3)

    

    processedImage = thin

    cv2.imwrite("OutputImage.png", processedImage)

    processed64 = ""

    with open('OutputImage.png', 'rb') as imagefile:
        processed64 = str(base64.b64encode(imagefile.read()))

    encoded = processed64[2:-1]

    # with open('b64.txt', 'w') as f:
    #    f.write(encoded)
    #    f.close()

    

    # img = base64.b64decode(imgbase64)
    # with open('img.png', 'w') as f:
    #     f.write(img)
    #     f.close()

    # cv2.imwrite("img.png", img)

    res['processed'] = encoded


    


    return jsonify(res)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port = 5000)

