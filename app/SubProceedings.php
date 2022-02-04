<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class SubProceedings extends Model
{
    protected $fillable = [
        'user_id',
        'proceedingsId',
        'name',
        'description',
        'openingDate',
        'deadline',
        'state',
    ];
}
