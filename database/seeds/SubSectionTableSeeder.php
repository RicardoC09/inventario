<?php

use Illuminate\Database\Seeder;
use App\subSection;

class SubSectionTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        subSection::create(['user_id'=>1,'sectionId'=>1,'subSectionCode'=>2103, 'name'=>'FACULTAD DE INGENIERIA']);
        subSection::create(['user_id'=>1,'sectionId'=>2,'subSectionCode'=>20131,'name'=>'PROGRAMA INGENIERIA AGRICOLA']);
        subSection::create(['user_id'=>1,'sectionId'=>2,'subSectionCode'=>20132,'name'=>'PROGRAMA INGENIERIA DE PETROLEOS']);
        subSection::create(['user_id'=>1,'sectionId'=>2,'subSectionCode'=>20133,'name'=>'PROGRAMA TECNOLOGIA EN OBRAS CIVILES']);
        subSection::create(['user_id'=>1,'sectionId'=>2,'subSectionCode'=>20134,'name'=>'PROGRAMA DE INGENIERIA ELECTRONICA']);
        subSection::create(['user_id'=>1,'sectionId'=>2,'subSectionCode'=>20135,'name'=>'PROGRAMA DE TECNOLOGIA EN DESARROLLO DE SOFTWARE']);
        subSection::create(['user_id'=>1,'sectionId'=>2,'subSectionCode'=>20136,'name'=>'PROGRAMA DE DOCTORADO EN CIENCIAS AGRARIAS']);
        subSection::create(['user_id'=>1,'sectionId'=>2,'subSectionCode'=>20137,'name'=>'PROGRAMA DE ESPECIALIZACION EN INGENIERIA AMBIENTAL']);
        

    }
}
