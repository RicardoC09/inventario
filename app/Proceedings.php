<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Proceedings extends Model
{
    protected $fillable = [
        'user_id',
        'subSerieId',
        'name',
        'description',
        'openingDate',
        'deadline',
        'state',
    ];
}
