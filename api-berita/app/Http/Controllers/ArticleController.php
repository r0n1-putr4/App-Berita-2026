<?php

namespace App\Http\Controllers;

use App\Models\Article;
use Illuminate\Http\Request;

class ArticleController extends Controller
{
    //
    public function index(){
        try{
            $articles =Article::all();
            $articlesResult = [];
            foreach($articles as $article){
        
                $articlesResult[] = [
                    "id" => $article->id,
                    "judul" => $article->judul,
                    "isi" => $article->isi,
                    "gambar" => $article->gambar,
                    "user" => $article->user->full_name,
                    "created_at" => $article->created_at,
                    "updated_at" => $article->updated_at
                ];
            }
            return response()->json(
                [
                    "message" => "Data artikel berhasil diambil",
                    "status" => true,
                    "dataArticles" => $articlesResult
                ]
            );
        }
        catch(\Exception $e){
            return response()->json(
                [
                    "message" => "Error:".$e->getMessage(),
                    "status" => false
                ]
            );
        }
    }

    public function store(Request $request){
        try{
            $validate = $this->validate($request,[
                "user_id" => "required|integer|exists:users,id",
                "judul" => "required|string",
                "isi" => "required|string",
                'gambar' => 'required|image|file|max:5120'
            ]);
            // $validate['gambar'] = $request->file('gambar')->store('images');

            $file = $request->file('gambar');

            $namaFile = time() . '_' . $file->getClientOriginalName();

            $destinationPath = app()->basePath('public/images');

            $file->move($destinationPath, $namaFile);

            $validate['gambar'] = 'images/' . $namaFile;
            
            $simpan = Article::create($validate);
            return response()->json(
                [
                    "status" => true,
                    "message" => "Artikel berhasil ditambahkan",                    
                    "data" => $simpan
                ]
            );
        } catch (\Exception $e) {
            return response()->json(
                [
                    "message" => "Error:" . $e->getMessage(),
                    "status" => false
                ]
            );
        }
    }

    public function destroy($id){
        try{
            $cek = Article::find($id);
            if(!$cek){
                return response()->json(
                    [
                        "message" => "Artikel tidak ditemukan",
                        "status" => false
                    ]
                );
            }
            if($cek->delete()){
                return response()->json(
                    [
                        "message" => "Artikel berhasil dihapus",
                        "status" => true
                    ]
                );
            }
        }catch(\Exception $e){
            return response()->json(
                [
                    "message" => "Error:".$e->getMessage(),
                    "status" => false
                ]
            );
        }
    }

    public function update(Request $request, $id){
        
        try{
            $validate = $this->validate($request, [
                "user_id" => "required|integer|exists:users,id",
                "judul" => "required|string",
                "isi" => "required|string",
                'gambar' => 'required|image|file|max:5120'
            ]);

            $file = $request->file('gambar');

            $namaFile = time() . '_' . $file->getClientOriginalName();

            $destinationPath = app()->basePath('public/images');

            $file->move($destinationPath, $namaFile);

            $validate['gambar'] = 'images/' . $namaFile;

            $update = Article::find($id);
            if($update->update($validate)){
                return response()->json(
                    [
                        "message" => "Artikel berhasil diupdate",
                        "status" => true,
                        "data" => $update
                    ]
                );
            }

        }catch(\Exception $e){
            return response()->json(
                [
                    "message" => "Error:".$e->getMessage(),
                    "status" => false
                ]
            );
        }

    }
}
