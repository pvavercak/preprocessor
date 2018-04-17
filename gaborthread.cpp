#include "gaborthread.h"

GaborThread::GaborThread(QObject *parent) : QObject(parent)
{

}

GaborThread::GaborThread(cv::Mat img, cv::Mat oMap, cv::Mat fMap, int blockSize, double sigma, double lambda, cv::Rect rect, cv::Mat enhancedImage):
    img(img), oMap(oMap), fMap(fMap), blockSize(blockSize), sigma(sigma), lambda(lambda), rect(rect), enhancedImage(enhancedImage)
{

}

void GaborThread::enhanceFragmentSlot(const bool &useFrequencyMap)
{
    cv::Mat kernel;
    cv::Mat subMat, sub;
    cv::Scalar s;

    for(int i = this->rect.y; i < this->rect.y + this->rect.height; i++){
        for(int j = this->rect.x; j < this->rect.x + this->rect.width; j++){
            if (useFrequencyMap) kernel = cv::getGaborKernel(cv::Size(this->blockSize,this->blockSize), this->sigma, this->oMap.at<float>(i,j), this->fMap.at<float>(i,j), 1, 0, CV_32F);
            else kernel = cv::getGaborKernel(cv::Size(this->blockSize,this->blockSize), this->sigma, this->oMap.at<float>(i,j), this->lambda, 1, 0, CV_32F);
            subMat = this->img(cv::Rect(j-this->blockSize/2, i-this->blockSize/2, this->blockSize, this->blockSize));
            subMat.convertTo(sub, CV_32F);
            cv::multiply(sub, kernel, sub);
            s = cv::sum(sub);
            this->enhancedImage.at<float>(i,j) = s[0];
        }
    }
    emit enhancementDoneSignal();
}

void GaborThread::enhancementDoneSlot()
{

}
