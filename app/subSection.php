<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class subSection extends Model
{
    protected $fillable = [
        'user_id',
        'sectionId',
        'subSectionCode',
        'name'
    ];
}
