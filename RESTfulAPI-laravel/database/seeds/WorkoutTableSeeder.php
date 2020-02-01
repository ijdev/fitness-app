<?php

use Illuminate\Database\Seeder;

class WorkoutTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        factory(App\Workout::class, 20)->create();

    }
}
