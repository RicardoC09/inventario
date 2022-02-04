<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Document extends Model
{
    protected $table = [
        'user_id',
        'proceedingsId',
        'subProceedingsId',
        'name',
        'description',
        'documentCreationDate',
        'support',
        'state'
    ];
}
