<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateProceedingsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('proceedings', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('user_id');
            $table->unsignedBigInteger('subSerieId');
            $table->string('name');
            $table->string('fileNumber');
            $table->string('description');
            $table->date('openingDate');
            $table->date('deadline')->nullable();
            $table->enum('state',['Público', 'Privado', 'Reservado']);
            $table->timestamps();

            //Relation
            $table->foreign('subSerieId')->references('id')->on('sub_series');
            $table->foreign('user_id')->references('id')->on('users');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('proceedings');
    }
}
