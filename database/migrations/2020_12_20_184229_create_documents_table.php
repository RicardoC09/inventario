<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDocumentsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('documents', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('user_id');
            $table->unsignedBigInteger('proceedingsId');
            $table->unsignedBigInteger('subProceedingsId')->nullable();
            $table->string('description');
            $table->string('name');
            $table->date('documentCreationDate');
            $table->string('support');
            $table->enum('state',['Abierto','Cerrado','Privado']);
            $table->timestamps();

            //Relation
            $table->foreign('proceedingsId')->references('id')->on('proceedings');
            $table->foreign('subProceedingsId')->references('id')->on('sub_proceedings');
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
        Schema::dropIfExists('documents');
    }
}
