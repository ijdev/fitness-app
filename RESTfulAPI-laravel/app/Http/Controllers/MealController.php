<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Meal;
use App\Http\Resources\MealResource;

class MealController extends Controller
{

    public function selftest(){
        $meals = auth()->user()->meals;
        return $meals;
        //return response()->json($meals);
    }
    public function index(){
        //$meals = Meal::all();
        $meals = auth()->user()->meals;
       // return $meals;
        return MealResource::collection($meals);
    }

    public function store(Request $request){
        if ($request->isMethod('POST')) {

                $meal = new Meal();
                $meal->name = $request->input('name');
                $meal->cal = $request->input('cal');
                $meal->user_id = auth()->user()->id;

                $meal->save();
                return new MealResource($meal);
            }
        return response()->json('ERROR storing', 401);
    }

    public function show($id){
        $meal = Meal::findOrFail($id);
        if ($meal !=null) {
            return new MealResource($meal);
        }
        return response()->json(['ID NOT FOUND-get failed'],404);
    }

    public function update(Request $request){
        if ($request->isMethod('PUT')) {
            $meal = Meal::findOrFail($request->input('id'));
            if ($meal!=null) {
                $meal->name = $request->input('name');
                $meal->cal = $request->input('cal');
                $meal->update();
            }
            return new MealResource($meal);
        }

        return response()->json('ERROR updating', 401);
    }

    public function destroy($id){
        $meal = Meal::findOrFail($id);
        if ($meal !=null) {
            if ($meal->delete())
                 return new MealResource($meal);
        }
        return response()->json(['ID NOT FOUND-delete failed'],404);
    }
}
