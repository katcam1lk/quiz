using UnityEngine;

public class SlippersController : MonoBehaviour
{
    public float throwForce = 10f;
    public Transform target;
    public float gravity = 9.8f;
    public float maxPredictionTime = 2f;

    private Rigidbody rb;
    private Vector3 initialVelocity;
    private float predictionTime;

    private void Start()
    {
        rb = GetComponent<Rigidbody>();
    }

    private void Update()
    {
        if (Input.GetMouseButtonDown(0))
        {
            ThrowSlippers();
        }
    }

    private void ThrowSlippers()
    {
        // Compute the initial velocity based on the throw force and direction
        Vector3 direction = (target.position - transform.position).normalized;
        initialVelocity = direction * throwForce;

        // Compute the prediction time based on the distance and initial velocity
        float distance = Vector3.Distance(transform.position, target.position);
        predictionTime = Mathf.Clamp(distance / throwForce, 0f, maxPredictionTime);

        // Apply the initial velocity
        rb.velocity = initialVelocity;
    }

    private void FixedUpdate()
    {
        // Update the trajectory prediction
        if (predictionTime > 0f)
        {
            Vector3 prediction = PredictTrajectory(predictionTime);
            transform.LookAt(transform.position + prediction);
        }
    }

    private Vector3 PredictTrajectory(float time)
    {
        Vector3 prediction = initialVelocity * time;
        prediction.y -= 0.5f * gravity * time * time; // Apply gravity
        return prediction;
    }
}
