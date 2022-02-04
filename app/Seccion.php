<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Seccion extends Model
{
    protected $fillable = [
        'user_id',
        'sectionCode',
        'name'
    ];
}
