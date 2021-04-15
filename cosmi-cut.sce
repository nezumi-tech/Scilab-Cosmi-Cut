//Image Processing and Computer Vision Toolbox for Scilab (IPCV)が必要

//コスミカット法のアルゴリズム
//加算合成
//比較明合成
//加算-比較明
//結果/(枚数-1)

//ファイルの準備
//Scilab カレントディレクトリ/alignd_num/0.tif, 1.tif, 2.tif, ..., n-1.tif (Light Frame)

//キャッシュクリア
clear();
xdel(winsid());

//Light Frameの枚数
num_of_img = 10;
img_index = num_of_img - 1; //0から始まるのでインデックスは枚数-1

[tate,yoko,oku] = size(imread(string(pwd()) + '\alignd_num\1.tif'));   //Light Frameから一枚読み出し、縦横と色数を取得する
img_added = uint32(zeros(tate, yoko, oku));     //加算合成用の配列（桁あふれするのでuint32）
img_brighter = uint32(zeros(tate, yoko, oku));  //比較明合成用の配列
//clear tate yoko oku;

for i = 0:1:img_index   //0,1,...,枚数-1まで
    img_new = imread(string(pwd()) + '\alignd_num\' + string(i) + '.tif'); //Light Frameから順番に1枚読み出し、
    img_added = img_added + img_new;            //加算合成して
    img_brighter = max(img_brighter, img_new);  //比較明合成する
    //clear img_new;
    disp(i) //進捗確認用
end

//img_cosmi = uint16((img_added -img_brighter) / img_index);
//img_out = uint16(img_added  / num_of_img);

//imshow(img_out);
//imwrite(img_out,'I:\AstroPhoto\out.tif');

imwrite(uint16(img_added  / num_of_img), string(pwd()) + '\img_avg.tif');                  //加算平均の画像を書き出し
imwrite(uint16((img_added - img_brighter) / img_index), string(pwd()) + '\img_cosmi.tif'); //コスミカット法の画像
imwrite(uint16(img_brighter), string(pwd()) + '\img_brighter.tif');                        //比較明合成の画像
