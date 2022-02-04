<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class SubSerie extends Model
{
    protected $fillable = [
        'serieId',
        'subSerieCode',
        'name'
    ];
}
