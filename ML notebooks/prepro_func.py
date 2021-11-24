import cv2
import pandas as pd
import numpy as np
from prettytable import PrettyTable
import pickle
import os

# Image Libs.
from PIL import Image
import cv2


def crop_image_from_gray(img,tol=7):
    if img.ndim ==2:
        mask = img>tol
        return img[np.ix_(mask.any(1),mask.any(0))]
    elif img.ndim==3:
        gray_img = cv2.cvtColor(img, cv2.COLOR_RGB2GRAY)
        mask = gray_img>tol
        
        check_shape = img[:,:,0][np.ix_(mask.any(1),mask.any(0))].shape[0]
        if (check_shape == 0): # image is too dark so that we crop out everything,
            return img # return original image
        else:
            img1=img[:,:,0][np.ix_(mask.any(1),mask.any(0))]
            img2=img[:,:,1][np.ix_(mask.any(1),mask.any(0))]
            img3=img[:,:,2][np.ix_(mask.any(1),mask.any(0))]
    #         print(img1.shape,img2.shape,img3.shape)
            img = np.stack([img1,img2,img3],axis=-1)
    #         print(img.shape)
        return img

def circle_crop(img, sigmaX = 30):   
    """
    Create circular crop around image centre    
    """    
    img = crop_image_from_gray(img)    
    img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    
    height, width, depth = img.shape    
    
    x = int(width/2)
    y = int(height/2)
    r = np.amin((x,y))
    
    circle_img = np.zeros((height, width), np.uint8)
    cv2.circle(circle_img, (x,y), int(r), 1, thickness=-1)
    img = cv2.bitwise_and(img, img, mask=circle_img)
    img = crop_image_from_gray(img)
    img=cv2.addWeighted(img,4, cv2.GaussianBlur( img , (0,0) , sigmaX) ,-4 ,128)
    return img 


IMG_SIZE=512

def preprocess_image(img):
   # print(os.path.join('../input/diabetic-retinopathy-resized/',file))
    #input_filepath = os.path.join('../input/diabetic-retinopathy-resized/',file)
    #img = cv2.imread(input_filepath)
    img = circle_crop(img) 
    #img= cv2.resize(cv2.cvtColor(img, cv2.COLOR_BGR2RGB), (IMG_SIZE,IMG_SIZE))
    img=cv2.resize(img,(IMG_SIZE,IMG_SIZE))
    return img


def process_img(path:str):
    img=cv2.imread(str)
    img=preprocess_image(img)
    cv2.imwrite(str,img)


path='/Users/msiddhu/Desktop/projects/Diabetic-Retinopathy-Detection/dr_processed.png'

process_img(path)