<?php

class ModuleUserfeed_MapperUserfeed extends Mapper
{
    public function subscribeUser($iUserId, $iSubscribeType, $iTargetId)
    {
        $sql = 'SELECT * FROM ' . Config::Get('db.table.userfeed_subscribe') . ' WHERE
                user_id = ?d AND subscribe_type = ?d AND target_id = ?d';
        if (!$this->oDb->select($sql, $iUserId, $iSubscribeType, $iTargetId)) {
            $sql = 'INSERT INTO ' . Config::Get('db.table.userfeed_subscribe') . ' SET
                    user_id = ?d, subscribe_type = ?d, target_id = ?d';
            $this->oDb->query($sql, $iUserId, $iSubscribeType, $iTargetId);
        }
    }

    public function unsubscribeUser($iUserId, $iSubscribeType, $iTargetId)
    {
        $sql = 'DELETE FROM ' . Config::Get('db.table.userfeed_subscribe') . ' WHERE
                user_id = ?d AND subscribe_type = ?d AND target_id = ?d';
        $this->oDb->query($sql, $iUserId, $iSubscribeType, $iTargetId);
    }

    public function updateSubscribes($iUserId, $aUserSubscribes, $iType)
    {
        if (!$iType) {
            $sql = 'DELETE FROM ' . Config::Get('db.table.userfeed_subscribe') . ' WHERE
                user_id = ?d ';
            $this->oDb->query($sql, $iUserId);
        } else {
            $sql = 'DELETE FROM ' . Config::Get('db.table.userfeed_subscribe') . ' WHERE
                user_id = ?d AND subscribe_type = ?d ';
            $this->oDb->query($sql, $iUserId, $iType);
        }

        $sql = 'INSERT INTO ' . Config::Get('db.table.userfeed_subscribe') . ' (user_id, subscribe_type, target_id) VALUES ';
        $aValues = array();
        if (count($aUserSubscribes['blogs'])) {
            foreach ($aUserSubscribes['blogs'] as $iTargetId) {
                $sql .= ' (?d, ?d, ?d),';
                $aValues = array_merge($aValues, array($iUserId, ModuleUserfeed::SUBSCRIBE_TYPE_BLOG, $iTargetId));
            }
        }
        if (count($aUserSubscribes['users'])) {
            foreach ($aUserSubscribes['users'] as $iTargetId) {
                $sql .= ' (?d, ?d, ?d),';
                $aValues = array_merge($aValues, array($iUserId, ModuleUserfeed::SUBSCRIBE_TYPE_USER, $iTargetId));
            }
        }

        $sql = substr($sql, 0, -1);

        return call_user_func_array(array($this->oDb, 'query'), array_merge(array($sql), $aValues));

    }

    public function getUserSubscribes($iUserId)
    {
        $sql = 'SELECT subscribe_type, target_id FROM ' . Config::Get('db.table.userfeed_subscribe') . ' WHERE user_id = ?d';
        $aSubscribes  = $this->oDb->select($sql, $iUserId);
        $aResult = array('blogs' => array(), 'users' => array());

        if (!count($aSubscribes)) return $aResult;

        foreach ($aSubscribes as $aSubscribe) {
            if($aSubscribe['subscribe_type'] == ModuleUserfeed::SUBSCRIBE_TYPE_BLOG) {
                $aResult['blogs'][] = $aSubscribe['target_id'];
            } elseif ($aSubscribe['subscribe_type'] == ModuleUserfeed::SUBSCRIBE_TYPE_USER) {
                $aResult['users'][] = $aSubscribe['target_id'];
            }
        }
        return $aResult;
    }

    public function readFeed($aUserSubscribes, $iCount, $iFromId)
    {
        if (!count($aUserSubscribes['blogs']) && !count($aUserSubscribes['users'])) return array();

        $sql = 'SELECT topic_id FROM ' . Config::Get('db.table.topic') . ' WHERE topic_publish = 1 AND ';
        $aParams = array();
        // Если получаем не последние, а более ранние записи, начиная с пределённой.
        if ($iFromId) {
            $sql .= 'topic_id < ?d AND (';
            $aParams[] = $iFromId;
        }
        if (count($aUserSubscribes['blogs'])) {
            $sql .= 'blog_id IN (?a) OR ';
            $aParams[] = $aUserSubscribes['blogs'];
        }
        if (count($aUserSubscribes['users'])) {
            $sql .= 'user_id IN (?a)';
            $aParams[] = $aUserSubscribes['users'];
        }
        // Если в конце лишний OR, убираем
        if (substr($sql, -3) == 'OR ') {
            $sql = substr($sql, 0, -4);
        }
        // Закрываем скобку. если получали не последние записи
        if ($iFromId) {
            $sql .= ')';
        }
        $sql .= ' ORDER BY topic_id DESC';
        if ($iCount) {
            $sql .= ' LIMIT 0,?d';
            $aParams[] = $iCount;
        }
        $aTopics = call_user_func_array(array($this->oDb, 'selectCol'), array_merge(array($sql), $aParams));
        return $aTopics;
    }
}