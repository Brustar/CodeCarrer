//
//  visionAnalysis.h
//  BowlingDemo
//
//  Created by Zhihai He on 3/20/13.
//  Copyright (c) 2013 Zhi Zhang. All rights reserved.
//

#ifndef BowlingDemo_visionAnalysis_h
#define BowlingDemo_visionAnalysis_h




#ifdef __cplusplus
extern "C"{
#endif
    
    #define BLK_SIZE					2
    #define BLK_SHIFT					1
    
    #define CC_MAX_NUM_LABELS	100
    #define MAX_CC_OBJECTS		60
    
    #define CC_SUPER_PIXEL_H	2
    #define CC_SUPER_PIXEL_W	2
    #define CC_SCAN_WINDOW_H	2
    #define CC_SCAN_WINDOW_W	2
    #define CC_FG_SUPER_PIX_THD	8
    
    /*///////////////////////////////////////structures ////////////////////////////*/
    
    typedef struct CCTag
    {
        int	maskWidth;
        int	maskHeight;
        int ccSuperPixelSize;
        int	superPixMapW;
        int	superPixMapH;
        
        int	numTotalObj;
        
        int	maxID;
        
        unsigned char*		dataSuperPixMap;
        unsigned char*		dataSuperPixFG;
        unsigned char*		eqCCLabelArray;
        
        int numObjects;
        int * boundingBoxes;
        
    }CCType;
    
    typedef struct GST_Tag
    {
        int width;
        int height;
        int widthStep;
        int nChannels;
        
        unsigned char * colorMask;
        
    }GST_Type;
    
    
    CCType * ccGst;
    GST_Type * gst;
    
    /*///////////////////////////////////////prototypes ////////////////////////////*/
    
    void initSystem(int width, int height, int widthStep, int nChannels);
    void visionAnalysis(unsigned char * image);
    //void ccShowResults(Mat& img);
    
    void modifyImage(unsigned char * image, int width, int height,
                     int widthStep, int cn);


    
#ifdef __cplusplus
};
#endif

#endif
