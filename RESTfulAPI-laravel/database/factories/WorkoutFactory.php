<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Model;
use Faker\Generator as Faker;

$factory->define(\App\Workout::class, function (Faker $faker) {
    return [
        'name' => $faker->name,
        'user_id' => App\User::all(['id'])->random(),
        'cal' => $faker->numberBetween(200,700),
    ];
});
