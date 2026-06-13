<?php

namespace App\Http\Controllers;

use App\Models\Article;
use App\Models\User;
use Illuminate\Http\Request;

class ArticleController extends Controller
{
    //
    public function index()
    {
        try {
            $articles = Article::all();
            $articlesResult = [];
            foreach ($articles as $article) {

                $articlesResult[] = [
                    "id" => $article->id,
                    "judul" => $article->judul,
                    "isi" => $article->isi,
                    "gambar" => $article->gambar,
                    "user_id" => $article->user_id,
                    "user" => $article->user->full_name,
                    "created_at" => \Carbon\Carbon::parse($article->created_at)
                        ->locale('id')
                        ->translatedFormat('d F Y H:i'),
                    "updated_at" => \Carbon\Carbon::parse($article->updated_at)->locale('id')->translatedFormat('d F Y H:i'), // $article->updated_at
                ];
            }
            return response()->json(
                [
                    "message" => "Data artikel berhasil diambil",
                    "status" => true,
                    "dataArticles" => $articlesResult
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

    public function store(Request $request)
    {
        try {
            $validate = $this->validate($request, [
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

    public function destroy($id)
    {
        try {
            $cek = Article::find($id);
            if (!$cek) {
                return response()->json(
                    [
                        "message" => "Artikel tidak ditemukan",
                        "status" => false
                    ]
                );
            }
            if ($cek->delete()) {
                return response()->json(
                    [
                        "message" => "Artikel berhasil dihapus",
                        "status" => true
                    ]
                );
            }
        } catch (\Exception $e) {
            return response()->json(
                [
                    "message" => "Error:" . $e->getMessage(),
                    "status" => false
                ]
            );
        }
    }

    public function update(Request $request, $id)
    {

        try {
            $validate = $this->validate($request, [
                "user_id" => "required|integer|exists:users,id",
                "judul" => "required|string",
                "isi" => "required|string",
                "gambar"  => "nullable|image|file|max:5120"
            ]);

            $update = Article::find($id);
            $update->user_id = $request->user_id;
            $update->judul   = $request->judul;
            $update->isi     = $request->isi;

            if ($request->hasFile('gambar')) {

                $file = $request->file('gambar');

                $namaFile = time() . '_' . $file->getClientOriginalName();

                $destinationPath = app()->basePath('public/images');

                $file->move($destinationPath, $namaFile);

                $update->gambar = 'images/' . $namaFile;
            }

            if ($update->save()) {
                return response()->json(
                    [
                        "message" => "Artikel berhasil diupdate",
                        "status" => true,
                        "data" => $update
                    ]
                );
            }
        } catch (\Exception $e) {
            return response()->json(
                [
                    "message" => "Error:" . $e->getMessage(),
                    "status" => false
                ]
            );
        }
    }

    public function showArticleUser($id)
    {
        try {
            $articles = User::find($id)->articles;
            $articlesResult = [];
            foreach ($articles as $article) {

                $articlesResult[] = [
                    "id" => $article->id,
                    "judul" => $article->judul,
                    "isi" => $article->isi,
                    "gambar" => $article->gambar,
                    "user_id" => $article->user_id,
                    "user" => $article->user->full_name,
                    "created_at" => \Carbon\Carbon::parse($article->created_at)
                        ->locale('id')
                        ->translatedFormat('d F Y H:i'),
                    "updated_at" => \Carbon\Carbon::parse($article->updated_at)->locale('id')->translatedFormat('d F Y H:i'), // $article->updated_at
                ];
            }
            return response()->json(
                [
                    "message" => "Data artikel berhasil diambil",
                    "status" => true,
                    "dataArticles" => $articlesResult
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
}
