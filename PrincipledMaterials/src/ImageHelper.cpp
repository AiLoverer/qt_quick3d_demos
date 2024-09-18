#include "ImageHelper.h"
#include <QtGui/QImageReader>

ImageHelper::ImageHelper(QObject *parent)
    : QObject{parent}
{}

QString ImageHelper::getSupportedImageFormatsFilter() const
{
    auto formats = QImageReader::supportedImageFormats();
    QString imageFilter = QStringLiteral("Image files (");
    for (const auto &format : std::as_const(formats))
        imageFilter += QStringLiteral("*.") + format + QStringLiteral(" ");
    imageFilter += QStringLiteral(")");
    return imageFilter;
}
