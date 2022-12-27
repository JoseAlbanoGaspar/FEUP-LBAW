<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Class BadgeGiven
 *
 * @property int $id_badge
 * @property int $id_user
 *
 * @property Badge $badge
 * @property User $user
 *
 * @package App\Models
 */
class BadgeGiven extends Model
{
	protected $table = 'badge_given';
	public $incrementing = false;
	public $timestamps = false;

	protected $casts = [
		'id_badge' => 'int',
		'id_user' => 'int'
	];

	public function badge()
	{
		return $this->belongsTo(Badge::class, 'id_badge');
}

	public function user()
	{
		return $this->belongsTo(User::class, 'id_user');
	}
}
