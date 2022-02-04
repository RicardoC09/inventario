<?php

use Illuminate\Database\Seeder;
use App\person;

class PeopleTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        person::create(['user_id'=>1,'document_Type_id'=>1,'document_Number'=>1075296095,'rol_id'=>1,'position_id'=>5,'avatar'=>'1-FotoUsuario-2021-03-23_04_48.jpeg']);       
    }
}
