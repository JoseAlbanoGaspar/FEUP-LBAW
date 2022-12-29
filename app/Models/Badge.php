<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

enum Rank: string
{
    case bronze = 'bronze';
    case silver = 'silver';
    case gold = 'gold';
}

/**
 * Class Badge
 *
 * @property int $id_badge
 * @property Rank $b_rank
 * @property string $name
 * @property string $condition
 *
 * @property Collection|BadgeGiven[] $badge_givens
 * @property Collection|NewBadgeNotification[] $new_badge_notifications
 *
 * @package App\Models
 */
class Badge extends Model
{
	protected $table = 'badge';
    protected $primaryKey = 'id_badge';

    public $timestamps = false;

	protected $casts = [
		//'b_rank' => 'USER-DEFINED'
	];

	protected $fillable = [
		'b_rank',
		'name',
		'condition'
	];

	public function badges_given()
	{
		return $this->hasMany(BadgeGiven::class, 'id_badge');
	}

	public function new_badge_notifications()
	{
//
		return $this->hasMany(NewBadgeNotification::class, 'id_badge');
	}
}
