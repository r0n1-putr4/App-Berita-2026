<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function index()
    {
        try {

            $users = User::all();
            $usersResult = [];
            foreach ($users as $user) {
                $usersResult[] = [
                    'id' => $user->id,
                    'username' => $user->username,
                    'email' => $user->email,
                    'full_name' => $user->full_name,
                    'gambar' => $user->gambar,
                    'created_at' => \Carbon\Carbon::parse($user->created_at)->locale('id')->translatedFormat('d F Y H:i'),
                    'updated_at' => \Carbon\Carbon::parse($user->updated_at)->locale('id')->translatedFormat('d F Y H:i'),
                ];
            }
            return response()->json([
                'status' => true,
                'message' => "Data User",
                'dataUsers' => $usersResult
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => $e->getMessage()
            ]);
        }
    }

    public function login(Request $request)
    {
        try {

            $this->validate($request, [
                'username' => 'required',
                'password' => 'required',
            ]);

            $user = User::where('username', $request->username)->where('password', md5($request->password))->first();
            if ($user) {
                return response()->json([
                    'status' => true,
                    'message' => 'Login Berhasil',
                    'dataLogin' => [
                        'id' => $user->id,
                        'username' => $user->username,
                        'email' => $user->email,
                        'full_name' => $user->full_name,
                        'gambar' => $user->gambar,
                        'is_admin' => $user->is_admin,
                    ]
                ]);
            } else {
                return response()->json([
                    'status' => false,
                    'message' => 'Username atau Password Salah'
                ]);
            }
        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => $e->getMessage()
            ]);
        }
    }


    public function store(Request $request)
    {

        try {

            $validate = $this->validate($request, [
                'username' => 'required|unique:users',
                'email' => 'required|email|unique:users',
                'password' => 'required',
                'full_name' => 'required',
                "gambar"  => "nullable|image|file|max:5120"
            ]);

            if ($request->hasFile('gambar')) {

                $file = $request->file('gambar');

                $namaFile = time() . '_' . $file->getClientOriginalName();

                $destinationPath = app()->basePath('public/images');

                $file->move($destinationPath, $namaFile);

                $validate['gambar'] = 'images/' . $namaFile;
            }

            $validate['password'] = md5($request->password);

            $save = User::create($validate);

            return response()->json([
                'status' => true,
                'message' => 'Data Berhasil Disimpan',
                'data' => $save
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => $e->getMessage()
            ]);
        }
    }

    public function update(Request $request, $id)
    {
        try {
            $validate = $this->validate($request, [
                'username' => 'required|unique:users',
                'email' => 'required|email|unique:users',
                'password' => 'required',
                'fullname' => 'required',
                "gambar"  => "nullable|image|file|max:5120"
            ]);

            $validate['password'] = md5($request->password);

            if ($request->hasFile('gambar')) {
                $file = $request->file('gambar');
                $namaFile = time() . '_' . $file->getClientOriginalName();
                $destinationPath = app()->basePath('public/images');
                $file->move($destinationPath, $namaFile);
                $validate['gambar'] = 'images/' . $namaFile;
            }

            $update = User::where('id', $id)->update($validate);

            return response()->json([
                'status' => true,
                'message' => 'Data Berhasil Diupdate',
                'data' => $update
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => $e->getMessage()
            ]);
        }
    }
}
