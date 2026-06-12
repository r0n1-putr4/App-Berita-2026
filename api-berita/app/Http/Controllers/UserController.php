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
            return response()->json([
                'status' => true,
                'message' => "Data User",
                'data' => $users
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
                    'data' => [
                        'id' => $user->id,
                        'username' => $user->username,
                        'email' => $user->email,
                        'fullname' => $user->fullname,
                        'gambar' => $user->gambar,
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
                'fullname' => 'required',
            ]);

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
            ]);

            $validate['password'] = md5($request->password);

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
