#ifndef IMAGEHELPER_H
#define IMAGEHELPER_H

#include <QObject>
#include <QQmlEngine>
#include <QtQml/QtQml>

class ImageHelper : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit ImageHelper(QObject *parent = nullptr);
    Q_INVOKABLE QString getSupportedImageFormatsFilter() const;

signals:
};

#endif // IMAGEHELPER_H
