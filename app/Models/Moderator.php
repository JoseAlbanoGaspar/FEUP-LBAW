<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Class Moderator
 *
 * @property int $id_moderator
 *
 * @property User $user
 *
 * @package App\Models
 */
class Moderator extends Model
{
	protected $table = 'moderator';
    protected $primaryKey = 'id_moderator';
	public $incrementing = false;
	public $timestamps = false;

	protected $casts = [
		'id_moderator' => 'int'
	];

	public function user()
	{
		return $this->belongsTo(User::class, 'id_moderator')
//					->where('user.id_user', '=', 'moderator.id_moderator')
					->where('user.id_user', '=', 'moderator.id_moderator');
	}
}
