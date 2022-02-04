<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class person extends Model
{
    protected $fillable = [
        'user_id',
        'document_Type_id',
        'document_Number',
        'rol_id',
        'position_id',
        'avatar'
    ];
}
