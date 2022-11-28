<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Class Administrator
 *
 * @property int $id_admin
 *
 * @property User $user
 *
 * @package App\Models
 */
class Administrator extends Model
{
	protected $table = 'administrator';
    protected $primaryKey = 'id_admin';

    public $incrementing = false;
	public $timestamps = false;

	protected $casts = [
		'id_admin' => 'int'
	];

	protected $fillable = [
		'id_admin'
	];

	public function user()
	{
		return $this->belongsTo(User::class, 'id_admin');

    }
}
