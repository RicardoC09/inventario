<?php

use Illuminate\Database\Seeder;
use App\User;

class UsersTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        User::create(['name'=>'Verónica del Pilar Hurtado Cortés','email'=>'veronica.hurtado@usco.edu.co','password'=> bcrypt('FacING2021')]);
    }
}
