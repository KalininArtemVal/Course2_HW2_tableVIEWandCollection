//
//  CustomFlowLayout.swift
//  Course2Week3Task2
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit

protocol PhotoLayoutDelegete {
    // метод для запроса высоты фотографии
    func collectionView(_ collectionView: UICollectionView,
                        heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
    
}

class CustomFlowLayout: UICollectionViewLayout {
    
    // 1 Ссылка на делегат
    var delegete: PhotoLayoutDelegete!
    // 2 Ннастройка макета: количество столбцов и дистанция между ними.
    private let numberOfColumns = 2
    private let cellPadding: CGFloat = 8
    
    // 3 Массив для кэширования вычисляемых атрибутов.
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    // 4 Объявляет два свойства для хранения размера содержимого.
    private var contentHeight: CGFloat = 0
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    // 5 возвращает размер содержимого представления коллекции. Мы используем оба параметра  contentWidthи contentHeightиз предыдущих шагов для расчета размера.
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        // 1 проверка на наличие обьектов в массиве кэш
        guard cache.isEmpty,
            let collectionView = collectionView
            else {
                return
        }
        // 2 ширина и высота столбца
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset: [CGFloat] = []
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
        
//        for i in 0..<numberOfColumns {
//            switch i {
//            case 0:
//                yOffset.append(CGFloat(100))
//            default:
//                yOffset.append(CGFloat(0))
//            }
//        }
            
            // (изначальные параметры) .init(repeating: 0, count: numberOfColumns)
        
        // 3
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            // 4 Устанавливаем высоту ячеек
            //4.1 приравниваем к высоте ячейки к высоте фото по индексу
            
            //let photoHeight = delegete.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath)
            
            //4.2.1 создаём высоту кастомной ячейки
            let height = CGFloat(200) //cellPadding * 2 + photoHeight
            //4.2.2 устанавливаем фрейм ячеек
            let frame = CGRect(x: xOffset[column],
                               y: yOffset[column],
                               width: columnWidth,
                               height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            //---------
            //4.3.1 создаём высоту первой кастомной ячейки
            let firstPhotoHeight = CGFloat(300)
            //4.3.2 устанавливаем фрейм первой ячейки
            let firstPhotoframe = CGRect(x: xOffset[column],
                                         y: yOffset[column],
                                         width: columnWidth,
                                         height: firstPhotoHeight)
            let insetFirstFrame = firstPhotoframe.insetBy(dx: cellPadding, dy: cellPadding)
            
            let firstAtribut = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            firstAtribut.frame = insetFirstFrame
            
            
            
            //cache.append(firstAtribut)
            //----------
            
            // 5
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            
            //cache.append(attributes)
            
            if item == 0 {
                cache.append(firstAtribut)
            } else {
                cache.append(attributes)
            }
            // 6
            contentHeight = max(contentHeight, frame.maxY)
            
            yOffset[column] = yOffset[column] + height
            
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
            var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
            
            for attributes in cache {
                if attributes.frame.intersects(rect) {
                    visibleLayoutAttributes.append(attributes)
                }
            }
            return visibleLayoutAttributes
    }
    
    
    override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
            return cache[indexPath.item]
    }
    
}



