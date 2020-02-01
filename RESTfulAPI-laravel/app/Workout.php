<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Workout extends Model
{
    protected $table = 'workouts';
    protected $fillable = ['name', 'cal', 'user_id'];

    public function user(){
        return $this->hasOne(User::class);
    }
}
