class PostageType < ActiveHash::Base
  self.data = [ 
    {id: 0, name: '選択してください'},
    {id: 1, name: '未定'}, 
    {id: 2, name: 'ゆうメール'},
    {id: 3, name: 'レターパック'},
    {id: 4, name: '普通郵便'},
    {id: 5, name: 'クロネコヤマト'},
    {id: 6, name: 'ゆうパック'},
    {id: 7, name: 'クリックポスト'},
    {id: 8, name: 'ゆうパケット'},
    {id: 9, name: 'スマートレター'},
    {id: 10, name: 'レターパックライト'},
    {id: 11, name: 'レターパックプラス'},
    {id: 12, name: '定形郵便'},
    {id: 13, name: '定形外郵便'}
  ]
end