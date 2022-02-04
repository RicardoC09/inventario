<?php

use Illuminate\Database\Seeder;
use App\position;

class PositionsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        position::create(['name'=>'Desarrollador de software']); 
        position::create(['name'=>'Secretaría Ejecutiva']); 
        position::create(['name'=>'Decano de Facultad']); 
        position::create(['name'=>'Secretaría de Facultad']); 
        position::create(['name'=>'Contratista']); 
        position::create(['name'=>'Asesora Academica']); 
        position::create(['name'=>'Asesora Juridica']); 
    }
}
