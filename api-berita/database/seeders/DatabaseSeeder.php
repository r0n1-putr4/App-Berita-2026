<?php

namespace Database\Seeders;

use App\Models\Article;
use App\Models\User;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // $this->call('UsersTableSeeder');
        User::create([
            "username" => "roni",
            "email" => "rn.putra@gmail.com",
            "password" => md5("123456"),
            "full_name" => "Roni Putra",
        ]);

        User::create([
            "username" => "eko",
            "email" => "eko@gmail.com",
            "password" => md5("123456"),
            "full_name" => "Eko Silalahi",
        ]);

        Article::create(
            [
                "user_id" => 1,
                "judul" => "Judul Artikel 1",
                "isi" => "Isi artikel 1"
            ]
        );

        Article::create(
            [
                "user_id" => 2,
                "judul" => "Judul Artikel 2",
                "isi" => "Isi artikel 2"
            ]
        );
        
    }
}
