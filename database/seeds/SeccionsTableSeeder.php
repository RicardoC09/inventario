<?php

use Illuminate\Database\Seeder;
use App\Seccion;

class SeccionsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Seccion::create(['user_id'=>1,'sectionCode'=>2,'name' => 'VICERRECTORIA ACADEMICA']);
        Seccion::create(['user_id'=>1,'sectionCode'=>2103,'name' => 'FACULTAD DE INGENIERIA']);
        
    }
}
