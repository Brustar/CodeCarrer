//
//  visionAnalysis.c
//  BowlingDemo
//
//  Created by Zhihai He on 3/20/13.
//  Copyright (c) 2013 Zhi Zhang. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "visionAnalysis.h"

void getColorMask(unsigned char * image, GST_Type * gst);
void initConnectedComponent(CCType* gNV_CC_Pram, int width, int height);
void connectedComponent(unsigned char *dataImgFGMask, CCType* ccGst);


void initSystem(int width, int height, int widthStep, int nChannels)
{
    
    gst = (GST_Type *)malloc(sizeof(GST_Type));
    ccGst = (CCType *)malloc(sizeof(CCType));
    
	gst->height = height;
	gst->width = width;
	gst->widthStep = widthStep;
	gst->nChannels = nChannels;
    
	width = gst->width;
	height = gst->height;
    
	gst->colorMask = (unsigned char *)malloc((width/BLK_SIZE) * (height/BLK_SIZE));
    
	initConnectedComponent(ccGst, width/BLK_SIZE, height/BLK_SIZE);
    
}

void visionAnalysis(unsigned char * image)
{

	//do color masking
	getColorMask(image, gst);
    
	//connnect component analysis
	connectedComponent(gst->colorMask, ccGst);

}


void rgb_to_hsv(int r, int g, int b, float *h, float *s, float *v)
{
    float min, max, delta, rc, gc, bc;
    
    rc = (float)r / 255.0;
    gc = (float)g / 255.0;
    bc = (float)b / 255.0;
    
    max = rc;
    if(gc > max) max = gc;
    if(bc > max) max = bc;
    
    min = rc;
    if(gc < min) min = gc;
    if(bc < min) min = bc;
    
    delta = max - min;
    *v = max;
    
    if (max != 0.0)
        *s = delta / max;
    else
        *s = 0.0;
    
    if (*s == 0.0) {
        *h = 0.0;
    }
    else {
        if (rc == max)
            *h = (gc - bc) / delta;
        else if (gc == max)
            *h = 2 + (bc - rc) / delta;
        else if (bc == max)
            *h = 4 + (rc - gc) / delta;
        
        *h *= 60.0;
        if (*h < 0)  *h += 360.0;
        
    }
}



void getColorMask(unsigned char * image, GST_Type * gst)
{
	int width, height, widthStep, nChannels, r, c, rBLK, cBLK;
	unsigned char * ptr, *colorMask;
	int cR, cG, cB;
	float h, s, v;
	int widthBLK, heightBLK;
    
	width = gst->width;
	height = gst->height;
	widthStep = gst->widthStep;
	nChannels = gst->nChannels;
	colorMask = gst->colorMask;
	
	widthBLK = width / BLK_SIZE;
	heightBLK = height / BLK_SIZE;
    
	/*memset(colorMask, 0, widthBLK*heightBLK);*/
    
	for(rBLK=0; rBLK<(height/BLK_SIZE); rBLK++)
        for(cBLK=0; cBLK<(width/BLK_SIZE); cBLK++)
        {
            cB = cG = cR = 0;
            for(r=0; r<BLK_SIZE; r++)
                for(c=0; c<BLK_SIZE; c++)
                {
                    ptr = image + ((rBLK<<BLK_SHIFT) + r) * widthStep + ((cBLK<<BLK_SHIFT)+c) * nChannels;
                    cB = cB + ptr[0];
                    cG = cG + ptr[1];
                    cR = cR + ptr[2];
                }
            
            cB = cB >> (BLK_SHIFT + BLK_SHIFT);
            cG = cG >> (BLK_SHIFT + BLK_SHIFT);
            cR = cR >> (BLK_SHIFT + BLK_SHIFT);
            
            rgb_to_hsv(cR, cG, cB, &h, &s, &v);
            
            h = h / 360;
            
            if((v > 0.3)  && (s > 0.2) && (h > 0.1) && (h < 0.4))
                *(colorMask + rBLK * widthBLK + cBLK) = 1;
            else
                *(colorMask + rBLK * widthBLK + cBLK) = 0;
            
        }
    
}


//------------------------------------------------------------------------------
//
//		Connect components
//
//------------------------------------------------------------------------------

void initConnectedComponent(CCType* ccGst, int width, int height)
{
	int	superPixMapW, superPixMapH;
    
	ccGst->maskWidth = width;
	ccGst->maskHeight = height;
    
	ccGst->superPixMapW	= width / CC_SUPER_PIXEL_W;
	ccGst->superPixMapH	= height / CC_SUPER_PIXEL_H;
    
	superPixMapW = ccGst->superPixMapW;
	superPixMapH = ccGst->superPixMapH;
    
	ccGst->dataSuperPixMap= (unsigned char*)malloc( superPixMapW*superPixMapH*sizeof(unsigned char) );
	memset( ccGst->dataSuperPixMap, 0, superPixMapH*superPixMapW*sizeof(unsigned char) );
    
	ccGst->dataSuperPixFG	= (unsigned char*)malloc( superPixMapH*superPixMapW*sizeof(unsigned char) );
	memset( ccGst->dataSuperPixFG, 0, superPixMapH*superPixMapW*sizeof(unsigned char) );
    
	ccGst->eqCCLabelArray	= (unsigned char*)malloc( (CC_MAX_NUM_LABELS + 1) * sizeof(unsigned char) );
    
	ccGst->boundingBoxes = (int *)malloc(MAX_CC_OBJECTS * 5 * sizeof(int));
    
	
}/*end: init_NV_connectedComponent*/



void connectedComponent(unsigned char *dataImgFGMask, CCType* ccGst)
{
	int	r, c, i, j, rBlk, cBlk;
	int	imgW, imgH, xA, xB, xC, xD;
	int	cumulatedBlkSum, superPixMapW, superPixMapH;
	int	ctFGPixels, imgDataWStep;
	int	lbVal, currLabel, xUL, yUL, xBR, yBR;
	int	tmpMaxLabel;
    
	unsigned char	*ptrImgData;
	unsigned char	*ptrImgData0;
	unsigned char	*ptrSuperPixMap;
	unsigned char	*ptrSuperPixMap0;
	unsigned char	*ptrSuperPixFG;
	unsigned char	*ptrSuperPixFG0;
	unsigned char	*ptrLabelMap;
	unsigned char	*ptrLabelMap0;
	unsigned char	*eqLabelArray;
	unsigned char	*ptrUCHAR;
    
	int * boundingBoxes;
    
    
	imgW			= ccGst->maskWidth;
	imgH			= ccGst->maskHeight;
	superPixMapW	= ccGst->superPixMapW;
	superPixMapH	= ccGst->superPixMapH;
    
	ptrSuperPixMap0 = ccGst->dataSuperPixMap;
	ptrSuperPixFG0	= ccGst->dataSuperPixFG;
	eqLabelArray	= ccGst->eqCCLabelArray;
    
	ptrImgData0		= dataImgFGMask;
    
	tmpMaxLabel		= 0;
    
    
	/* reset foreground super pixels.*/
	memset( ccGst->dataSuperPixMap, 0, superPixMapH*superPixMapW*sizeof(unsigned char) );
	memset( ccGst->dataSuperPixFG, 0, superPixMapH*superPixMapW*sizeof(unsigned char) );
    
	ptrUCHAR			= ccGst->eqCCLabelArray;
    
	for ( i=0; i<(CC_MAX_NUM_LABELS + 1); i+=1 )
	{
		*ptrUCHAR	=	i;
		ptrUCHAR	+=	1;
	}
    
	ccGst->numTotalObj	= 0;
    
    
	/***********************************************/
	/*	Sum up foreground count within suer pixels.*/
	/***********************************************/
    
	imgDataWStep			= ( CC_SUPER_PIXEL_H * imgW );
    
	for ( rBlk=0; rBlk < superPixMapH; rBlk+=1 )
	{
		for ( cBlk=0; cBlk < superPixMapW; cBlk+=1)
		{
			ptrImgData		= ptrImgData0 + (rBlk * imgDataWStep) + (cBlk * CC_SUPER_PIXEL_W);
            
			cumulatedBlkSum	= 0;
            
			for ( r=0; r < CC_SUPER_PIXEL_H; r+=1 )
			{
				for ( c=0; c < CC_SUPER_PIXEL_W; c+=1 )
				{
					if ( (*ptrImgData) > 0 ) cumulatedBlkSum	+= 1;
                    
					ptrImgData += 1;
				}/* c */
                
				ptrImgData	+= (imgW - CC_SUPER_PIXEL_W);
			}/* r */
            
			*(ptrSuperPixFG0 + (rBlk * superPixMapW) + cBlk)	= cumulatedBlkSum;
		}/*end of: for ( cBlk )*/
	}/*end of: for ( rBlk )*/
    
    
	/**************************/
	/* Scan image for objects */
	/**************************/
    
	for ( r=0; r<(superPixMapH - CC_SCAN_WINDOW_H); r+= 1 )
	{
		for ( c=0; c<(superPixMapW - CC_SCAN_WINDOW_W); c+= 1 )
		{
			/* sum up pixel in scanning window.*/
            
			ctFGPixels		= 0;
            
			ptrSuperPixFG	= ptrSuperPixFG0 + (r * superPixMapW) + c;
            
			for (i=0; i<CC_SCAN_WINDOW_H; i+=1)
			{
				for (j=0; j<CC_SCAN_WINDOW_W; j+=1)
				{
					ctFGPixels		+= ( *ptrSuperPixFG );
					ptrSuperPixFG	+= 1;
                    
				}/* col: j */
                
				ptrSuperPixFG		+= (superPixMapW - CC_SCAN_WINDOW_W);
			}/* row: i */
            
            
			/* mark foreground.*/
            
			if ( ctFGPixels > CC_FG_SUPER_PIX_THD )
			{
				ptrSuperPixMap	= ptrSuperPixMap0 + (r * superPixMapW) + c;
                
				for (i=0; i<CC_SCAN_WINDOW_H; i+=1)
				{
					for (j=0; j<CC_SCAN_WINDOW_W; j+=1)
					{
						*( ptrSuperPixMap )	= 255;
						ptrSuperPixMap		+=1;
					}
                    
					ptrSuperPixMap			+= ( superPixMapW - CC_SCAN_WINDOW_W);
				}
                
			}/*end of: mark foreground.*/
            
		}/*end of: for ( c )*/
	}/*end of: for ( r )*/
    
    
	/*********************************/
	/*	Connected component labeling.*/
	/*********************************/
    
	currLabel			= 1;
    
	/* put label in [*ptrSuperPixFG].*/
	memset( ccGst->dataSuperPixFG, 0, superPixMapH*superPixMapW*sizeof(unsigned char) );
	ptrLabelMap0		= ccGst->dataSuperPixFG;
    
	/* the 1st pass for setting label and flooding label.*/
	for ( r=1; r<superPixMapH; r+=1 )
	{
		ptrSuperPixMap	= ptrSuperPixMap0 + (r * superPixMapW) + 1;
		ptrLabelMap		= ptrLabelMap0 + (r * superPixMapW) + 1;
        
		for ( c=1; c<superPixMapW; c+=1 )
		{
			if ( (*ptrSuperPixMap) > 0 )
			{
				/*	xB	xC	xD	*/
				/*	xA	x		*/
				xA		= *(ptrLabelMap -1 );
				xB		= *(ptrLabelMap -1 - superPixMapW);
				xC		= *(ptrLabelMap - superPixMapW);
				xD		= *(ptrLabelMap - superPixMapW + 1);
                
				lbVal	= CC_MAX_NUM_LABELS;
                
				if(xA > 0)						lbVal	= xA;
				if((xB > 0) && (xB < lbVal))	lbVal	= xB;
				if((xC > 0) && (xC < lbVal))	lbVal	= xC;
				if((xD > 0) && (xD < lbVal))	lbVal	= xD;
                
				if (lbVal < CC_MAX_NUM_LABELS)
				{
					/* make connection and flood label.*/
					if (xA > lbVal)
					{
						*(eqLabelArray + xA)	= *(eqLabelArray + lbVal);
					}
					if (xB > lbVal)
					{
						*(eqLabelArray + xB)	= *(eqLabelArray + lbVal);
					}
					if (xC > lbVal)
					{
						*(eqLabelArray + xC)	= *(eqLabelArray + lbVal);
					}
					if (xD > lbVal)
					{
						*(eqLabelArray + xD)	= *(eqLabelArray + lbVal);
					}
				}
				else
				{
					/* new label.*/
					lbVal	= currLabel;
					if (currLabel < (CC_MAX_NUM_LABELS -1))
					{
						currLabel += 1;
					}
				}
                
				/* save label for this pixel.*/
				*(ptrLabelMap)	= lbVal;
                
			}/*end of: if foreground.*/
            
			ptrSuperPixMap	+= 1;
			ptrLabelMap		+= 1;
		}/* col */
	}/* row */
    
    
	/* the 2nd pass to flush with equivalent labels.*/
	for ( r=1; r<superPixMapH; r+=1 )
	{
		ptrLabelMap		= ptrLabelMap0 + (r * superPixMapW) + 1;
        
		for ( c=1; c<superPixMapW; c+=1 )
		{
			lbVal		= (*ptrLabelMap);
            
			if (lbVal  > 0 )
			{
				xUL		= c * CC_SUPER_PIXEL_W;
				yUL		= r * CC_SUPER_PIXEL_H;
				xBR		= xUL + CC_SUPER_PIXEL_W;
				yBR		= yUL + CC_SUPER_PIXEL_H;
                
				/* equivalent label.*/
				lbVal			= *(eqLabelArray + lbVal);
				*ptrLabelMap	= lbVal;
                
				// find the maximal label.
				if ( lbVal > tmpMaxLabel )
				{
					tmpMaxLabel	= lbVal;
				}
                
				// display only:
				*(ccGst->dataSuperPixMap + (r * superPixMapW) + c ) = lbVal;
                
			}/*end of: if foreground.*/
            
			ptrLabelMap	+= 1;
		}/* col */
	}/* row */
    
	// save the maximal label value.
	ccGst->maxID	= tmpMaxLabel;
    
	if(tmpMaxLabel > 0)
	{
		tmpMaxLabel = tmpMaxLabel;
	}
    
	//determine the bounding boxes of each object
	boundingBoxes = ccGst->boundingBoxes;
	for(i=0; i<=ccGst->maxID; i++)
	{
		boundingBoxes[5*i+0] = 0;
		boundingBoxes[5*i+1] = 10000;
		boundingBoxes[5*i+2] = 10000;
		boundingBoxes[5*i+3] = -10000;
		boundingBoxes[5*i+4] = -10000;
        
	}
    
    
	for ( r=1; r<superPixMapH; r+=1 )
	{
		ptrLabelMap	= ccGst->dataSuperPixMap + (r * superPixMapW) + 1;
        
		for ( c=1; c<superPixMapW; c+=1 )
		{
			lbVal = *ptrLabelMap; 
			ptrLabelMap++;
            
			if(lbVal >= 1)
			{
				if(lbVal > (CC_MAX_NUM_LABELS-1)) lbVal = CC_MAX_NUM_LABELS-1; 
                
				lbVal = lbVal - 1;
				boundingBoxes[5*lbVal] = boundingBoxes[5*lbVal] + 1;
				if(r < boundingBoxes[5*lbVal+1]) boundingBoxes[5*lbVal+1] = r;
				if(c < boundingBoxes[5*lbVal+2]) boundingBoxes[5*lbVal+2] = c;
				if(r > boundingBoxes[5*lbVal+3]) boundingBoxes[5*lbVal+3] = r;
				if(c > boundingBoxes[5*lbVal+4]) boundingBoxes[5*lbVal+4] = c;				
			}
            
		}
	}
    
	// save the maximal label value.
	ccGst->maxID	= tmpMaxLabel;
	ccGst->numObjects = tmpMaxLabel;
    
	
}/*end of: void connectedComponent() | connected component labeling.*/

/*

void ccShowResults(Mat& frame)
{
	CCType * ccGst = &CCGST;
	GST_Type * gst = &GST;
    
	int k, r, c, width, height, maskWidth, maskHeight, sC, sR, widthStep, lbVal;
	unsigned char *ptr;
	int superPixMapW, superPixMapH;
	int colorArray[6][3] = {{0, 0, 0}, {255, 255, 255}, {255, 0, 0}, {255, 255, 0}, {0, 0, 255}, {255, 0, 255}};
    
	maskWidth = ccGst->maskWidth;
	maskHeight = ccGst->maskHeight;
	width = gst->width;
	height = gst->height;
    
	superPixMapW	= ccGst->superPixMapW;
	superPixMapH	= ccGst->superPixMapH;
	widthStep = frame->widthStep;
    
    
#if 1
	for(r=0; r<height; r++)
        for(c=0; c<width; c++)
        {
            
            ptr = (unsigned char *)(frame->imageData + r * widthStep + c * 3);
            if(*(gst->colorMask + (r/BLK_SIZE) * (width/BLK_SIZE) + (c/BLK_SIZE)) == 1)
            {
                ptr[0] = 128;
                ptr[1] = 255;
                ptr[2] = 255;
            }
            else
            {
                ptr[0] = 0;
                ptr[1] = 0;
                ptr[2] = 0;
            }
            
        }
#endif
    
    
#if 0
	for(r=0; r<height; r++)
        for(c=0; c<width; c++)
        {
            sR = r / BLK_SIZE /  CC_SUPER_PIXEL_H;
            sC = c / BLK_SIZE / CC_SUPER_PIXEL_W;
            
            lbVal = *(ccGst->dataSuperPixMap + (sR * superPixMapW) + sC);
            if(lbVal > 0) lbVal = (lbVal - 1) % 5 + 1;
            
            ptr = (unsigned char *)(frame->imageData + r * widthStep + c * 3);
            ptr[0] = colorArray[lbVal][2];
            ptr[1] = colorArray[lbVal][1];
            ptr[2] = colorArray[lbVal][0];
            
        }
#endif
    
#if 0
	int R0, R1, C0, C1;
    
	//plot the bounding boxes
	for(k=0; k<ccGst->numObjects; k++)
	{
		R0 = ccGst->boundingBoxes[5*k+1] * BLK_SIZE *  CC_SUPER_PIXEL_H;
		C0 = ccGst->boundingBoxes[5*k+2] * BLK_SIZE *  CC_SUPER_PIXEL_W;
		R1 = ccGst->boundingBoxes[5*k+3] * BLK_SIZE *  CC_SUPER_PIXEL_H;
		C1 = ccGst->boundingBoxes[5*k+4] * BLK_SIZE *  CC_SUPER_PIXEL_W;
		cvRectangle(frame, cvPoint(C0, R0), cvPoint(C1, R1), CV_RGB(255, 128, 0), 3, 8, 0);
		
	}
    
#endif
    
    
    
}
*/

void modifyImage(unsigned char * image, int width, int height, int widthStep, int cn)
{
    int r, c;
    
    for(r=100; r<height; r++)
        for(c=100;c<width; c++)
        {
            *(image + r * widthStep + c * cn + 0) = 0;
            *(image + r * widthStep + c * cn + 1) = 0;
            *(image + r * widthStep + c * cn + 2) = 0;
            
        }
}