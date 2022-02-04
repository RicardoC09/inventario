<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePeopleTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('people', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('user_id');
            $table->unsignedBigInteger('document_Type_id');
            $table->string('document_Number');
            $table->unsignedBigInteger('rol_id');
            $table->unsignedBigInteger('position_id');
            $table->string('avatar');
            $table->timestamps();


            //Relation
            $table->foreign('user_id')->references('id')->on('users');
            $table->foreign('document_Type_id')->references('id')->on('document_types');
            $table->foreign('rol_id')->references('id')->on('roles');
            $table->foreign('position_id')->references('id')->on('positions');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('people');
    }
}
