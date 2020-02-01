<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\User;

class Meal extends Model
{
    protected $table = 'meals';
    protected $fillable = ['name', 'cal'];

    public function user(){
        return $this->hasOne(User::class);
    }
}
