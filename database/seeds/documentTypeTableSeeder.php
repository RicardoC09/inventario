<?php

use Illuminate\Database\Seeder;
use App\documentType;

class documentTypeTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        documentType::create(['name' => 'Cédula de Ciudadanía']); 
        documentType::create(['name' => 'Tarjeta de identidad']); 
        documentType::create(['name' => 'Tarjeta Pasaporte']); 
        documentType::create(['name' => 'Cédula de Extranjería']);
    }
}
