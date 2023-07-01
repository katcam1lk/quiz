using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NewBehaviourScript : MonoBehaviour
{
    public GameObject player;
    public GameObject slippers; // Variable para sa mga slippers
    public float speed;
    public float distanceBetween;

    private float distance;
    private bool isChasingPlayer = false; // Variable para sa paghabol nung enemy

    void Start()
    {
        
    }

    void Update()
    {
        // Tignan kung nahawakan na ng player yung slippers
        if (slippers.activeSelf && !isChasingPlayer)
        {
            isChasingPlayer = true;
        }

        // Kung nag-hahabol na ang enemy
        if (isChasingPlayer)
        {
            distance = Vector2.Distance(transform.position, player.transform.position);
            Vector2 direction = player.transform.position - transform.position;
            direction.Normalize();
            float angle = Mathf.Atan2(direction.y, direction.x) * Mathf.Rad2Deg;

            if (distance < distanceBetween)
            {
                transform.position = Vector2.MoveTowards(transform.position, player.transform.position, speed * Time.deltaTime);
                transform.rotation = Quaternion.Euler(Vector3.forward * angle);
            }
        }
    }
}
