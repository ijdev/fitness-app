<?php

use Illuminate\Database\Seeder;


class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
         $this->call(MealTableSeeder::class);
        $this->call(UserTableSeeder::class);
        $this->call(WorkoutTableSeeder::class);


    }
}
