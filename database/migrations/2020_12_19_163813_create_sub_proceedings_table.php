<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSubProceedingsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('sub_proceedings', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('user_id');
            $table->unsignedBigInteger('proceedingsId');
            $table->string('name');
            $table->string('subFileNumber');
            $table->string('description');
            $table->date('openingDate');
            $table->date('deadline')->nullable();
            $table->enum('state',['Público', 'Privado', 'Reservado']);
            $table->timestamps();

            //Relation
            $table->foreign('proceedingsId')->references('id')->on('proceedings');
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
        Schema::dropIfExists('sub_proceedings');
    }
}
