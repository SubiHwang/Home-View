//
//  AddCharacterViewController.swift
//  home
//
//  Created by 황수비 on 2023/05/29.
//

import Foundation
import UIKit
import PanModal

class AddCharacterViewController: UIViewController{
    
    
    @IBOutlet weak var CharacterCollectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //collection view에 대한 설정
       CharacterCollectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        CharacterCollectionView?.dataSource=self
        CharacterCollectionView?.delegate=self
        
        //   ----닙파일이랑 연결----
        //닙파일 연결시켜주기
        let CharacterCollectionViewCellNib = UINib(nibName: String(describing: CharacterCollectionViewCell.self), bundle: nil)
        
        //가져온 닙파일을 콜렉션뷰에 셀로 등록하기
        self.CharacterCollectionView?.register(CharacterCollectionViewCellNib, forCellWithReuseIdentifier: String(describing: CharacterCollectionViewCell.self))
                                            
        //콜렉션 뷰의 콜렉션 뷰 레이아웃 설정하기
        self.CharacterCollectionView?.collectionViewLayout = createCompositionalLayout()
            
        // ----닙파일이랑 연결----
    }
    
}

//MARK: - panModal부분 처리
extension AddCharacterViewController: PanModalPresentable{
    var panScrollable: UIScrollView?{
        return CharacterCollectionView
    }
    var shortFormHeight: PanModalHeight{
        return .contentHeight(300)
    }
    var longFormHeight: PanModalHeight{
        return .maxHeightWithTopInset(40)
    }
}


fileprivate func createCompositionalLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

        // 아이템에 대한 사이즈
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2))

        // 아이템 만들기
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // 아이템 간의 간격 설정
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        // 그룹사이즈
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.4))

        // 그룹
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)

        // 섹션 만들기
        let section = NSCollectionLayoutSection(group: group)

        // 섹션 간격
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

        return section
    }
    return layout
}
                                        
//collection view를 몇개 보여주고 각 섹션은 몇개인지 그런거 입력하는 것
//datasource는 프로토콜이 필수임
extension AddCharacterViewController:UICollectionViewDataSource{
    
    //각 섹션에 들어가는 아이템 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GlobalCharacter.shared.characterImageArray.count
    }
    
    //각 collection view cell 에 대한 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       
        //닙 파일 안의 요소에 접근
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CharacterCollectionViewCell.self), for: indexPath) as! CharacterCollectionViewCell

    
        
        //각 cell안에 image 설정
        cell.CharacterImageView.image = GlobalCharacter.shared.characterImageArray[indexPath.row]
        
        return cell
        
    }
    
    
}

//collection view 액션과 관련된 것들
extension AddCharacterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cellIndex = indexPath.item
        let cellInSection = cellIndex % 3

        print("Cell selected at indexPath: \(indexPath)")

        if cellInSection == 0 {
            GlobalMAainCharacter.shared.systemMainImageName = "Character"
            GlobalResponseBtn.shared.systemResponseBtnImageName = "Character"
            dismiss(animated: true, completion: nil)
        } else if cellInSection == 1 {
            GlobalMAainCharacter.shared.systemMainImageName = "secondCharacter"
            GlobalResponseBtn.shared.systemResponseBtnImageName = "secondCharacter"
            dismiss(animated: true, completion: nil)
        } else {
            GlobalMAainCharacter.shared.systemMainImageName = "thirdCharacter"
            GlobalResponseBtn.shared.systemResponseBtnImageName = "thirdCharacter"
            dismiss(animated: true, completion: nil)
        }
        
        

    }
}



