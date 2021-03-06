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
        
        // 3
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            //4.2.1 Устанавливаем высоту кастомной ячейки
            let height: CGFloat = (indexPath.item == 0 ? 300 : 200)
            //4.2.2 устанавливаем фрейм ячеек
            let frame = CGRect(x: xOffset[column],
                               y: yOffset[column],
                               width: columnWidth,
                               height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            // 5
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            // 6
            contentHeight = max(contentHeight, frame.maxY)
            
            yOffset[column] = yOffset[column] + height
            
            //расположение ячеек в столбцах
            switch item {
            case 0:
                column = 1
            case 1:
                column = 1
            case 2:
                column = 0
            case 3:
                column = 1
            default:
                column = column < (numberOfColumns - 1) ? (column + 1) : 0
            }
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



