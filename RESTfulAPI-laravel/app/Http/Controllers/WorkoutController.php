<?php

namespace App\Http\Controllers;

use App\Http\Resources\MealResource;
use App\Workout;
use Illuminate\Http\Request;

class WorkoutController extends Controller
{
    //
    public function selftest(){
        $workouts = auth()->user()->workouts;
        return $workouts;
        //return response()->json($workouts);
    }
    public function index(){
        //$workouts = Workout::all();
        $workouts = auth()->user()->workouts;
        // return $workouts;
        return MealResource::collection($workouts);
    }

    public function store(Request $request){
        if ($request->isMethod('POST')) {

            $workout = new Workout();
            $workout->name = $request->input('name');
            $workout->cal = $request->input('cal');
            $workout->user_id = auth()->user()->id;

            $workout->save();
            return new MealResource($workout);
        }
        return response()->json('ERROR storing', 401);
    }

    public function show($id){
        $workout = Workout::findOrFail($id);
        if ($workout !=null) {
            return new MealResource($workout);
        }
        return response()->json(['ID NOT FOUND-get failed'],404);
    }

    public function update(Request $request){
        if ($request->isMethod('PUT')) {
            $workout = Workout::findOrFail($request->input('id'));
            if ($workout!=null) {
                $workout->name = $request->input('name');
                $workout->cal = $request->input('cal');
                $workout->update();
            }
            return new MealResource($workout);
        }

        return response()->json('ERROR updating', 401);
    }

    public function destroy($id){
        $workout = Workout::findOrFail($id);
        if ($workout !=null) {
            if ($workout->delete())
                return new MealResource($workout);
        }
        return response()->json(['ID NOT FOUND-delete failed'],404);
    }
}
