# Bachelor thesis: Inverse problem for resistor networks

## Abstract
This thesis presents the mathematics behind a grid-based temperature sensor. In addition, it also applies the computational theory to exemplary surfaces. This grid sensor could be utilized in many fields of industry. It would offer effortless and precise temperature measurements around any subject. This could uncover previously undetected heat dissipation and increase the stability of an industrial process. 

The sensor is a grid-like structure with nodes and edges. A resistance is assigned to each edge. Since temperature can be derived from resistance, the temperature distribution can be obtained when resistance of the grid is known. 

The resistance is obtained by formulating a non-linear ill-posed inverse problem using only boundary measurements and the topology of the grid. The problem is then solved using the Gauss-Newton algorithm paired with Tikhonov regularization. A Laplacian matrix with the Neumann boundary condition was used for regularization. The algorithm is found to converge on accurate solutions when the parameters reflect both the application and the environment.


## Remarks
The final results, error analysis, and convergence are not recorded as in, but can rather be derived from the core code with minimal effort. The code contains references to the /doc/thesis.pdf.


## Software prerequisites
Built on Matlab 2017b.


## Author
[Rustam Latypov](mailto:rustam.latypov@aalto.fi)


## Acknowledgements
Supervisor and instructor of Bachelor thesis: [Antti Hannukainen](mailto:antti.hannukainen@aalto.fi)



