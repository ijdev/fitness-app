<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Meal;
use Faker\Generator as Faker;
use Illuminate\Support\Str;

$factory->define(Meal::class, function (Faker $faker) {
    return [
        'name' => $faker->name,
        'user_id' => App\User::all(['id'])->random(),
        'cal' => $faker->numberBetween(200,700),
    ];
});
