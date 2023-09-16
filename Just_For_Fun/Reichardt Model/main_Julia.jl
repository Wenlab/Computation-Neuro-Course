using Plots

# Interface
println("Change color? 1 for yes and 0 for no.")
is_changed = parse(Int, readline())

if is_changed != 0 && is_changed != 1
    error("Why so rebellious?")
end

# Parameters
n_points = 1000
width = 2000
height = 300
speed = 100
size_of_point = 2
frame_count = 0
n_change = 1

# Initialize positions of points uniformly
x = rand(n_points) .* width
y = rand(n_points) .* height
colors = vcat(ones(Int, div(n_points, 2)), zeros(Int, div(n_points, 2)))

# Animate
while true

    global frame_count # Make sure to use the global variable
    # Update frame_count
    frame_count += 1

    # Update positions
    x .+= speed

    # Periodic boundary conditions
    x[x .> width] .-= width

    # Change color
    if is_changed == 1 && frame_count % n_change == 0
        colors .= 1 .- colors
    end

    # Create and display a new plot at each iteration
    p = scatter(x[colors .== 1], y[colors .== 1], 
        legend = false, 
        xlim = (0, width), 
        ylim = (0, height), 
        markersize = size_of_point, 
        markerstrokewidth = 0,
        color = :white,
        background_color = :grey
    )

    # scatter!
    scatter!(p, x[colors .== 0], y[colors .== 0], 
        legend = false, 
        markersize = size_of_point, 
        markerstrokewidth = 0,
        color = :black,
        background_color = :grey
    )

    # show the plot
    display(p)
    
    # Pause to allow plot update
    sleep(0.01)

end