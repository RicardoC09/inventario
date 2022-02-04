<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Serie extends Model
{
    protected $fillable = [
        'user_id',
        'subSectionId',
        'serieCode',
        'name'
    ];
}
